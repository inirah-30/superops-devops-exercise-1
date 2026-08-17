# Load-Balanced Web Server

A load-balanced, highly-available web server environment on AWS, built entirely with Terraform. Two nginx web servers sit behind an Application Load Balancer across two Availability Zones; if either server goes down, the ALB automatically fails traffic over to the healthy one.

---

## Architecture

```
                              Internet
                                 │
                                 ▼
                    Application Load Balancer
                     (public, spans both AZs)
                                 │
                          Target Group
                        (HTTP health check)
                        /                \
                       ▼                  ▼
              EC2 - webserver1     EC2 - webserver2
              AZ: ap-south-1a      AZ: ap-south-1b
              nginx, "Hello        nginx, "Hello
              World from           World from
              Web Server 1"        Web Server 2"
```

**VPC:** `10.0.0.0/16`, two public subnets (`10.0.1.0/24`, `10.0.2.0/24`), one per AZ, each with a route to an Internet Gateway.

---

## Design

**Application Load Balancer**
ALB operates at Layer 7 (HTTP-aware) and its health checks can actively detect an unhealthy backend and stop routing to it — this is the actual mechanism that produces automatic failover.

**EC2 instances.**
The requirement is specifically that removing a web server causes the ALB to fail traffic over to the survivor — i.e., proving the *load balancer's* health-check-driven failover works. Two standalone instances registered directly to the target group isolate and clearly demonstrate the specific behavior being tested.

**Two Availability Zones.**
Standard high-availability practice — a single-AZ deployment would be a single point of failure at the infrastructure level, independent of anything Terraform or the ALB does.
---

## Repository structure

```
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── .gitignore
└── modules/
    ├── networking/
    ├── security/
    ├── ec2/
    └── load_balancer/ 
```

**Note:** `terraform.tfvars` is intentionally not committed to this repository (it's excluded via `.gitignore`), since it contains environment-specific values including an IP address restriction for SSH access. See **Setup** below for the values you'll need to supply.

---


## Setup

1. Clone this repository:
   ```bash
   git clone git@github.com:inirah-30/superops-devops-exercise-1.git
   cd superops-devops-exercise-1
   ```

2. Create a `terraform.tfvars` file:

   sample file:
   ```hcl
   aws_region = "ap-south-1"
   project_name = "superops-loadbalancer"

   vpc_cidr = "10.0.0.0/16"
   public_subnet_1_cidr = "10.0.1.0/24"
   public_subnet_2_cidr = "10.0.2.0/24"

   availability_zone_1 = "ap-south-1a"
   availability_zone_2 = "ap-south-1b"

   instance_type = "t2.micro"
   key_name          = "your-ec2-key-pair-name"

   ssh_allowed_cidr = "YOUR_IP_HERE/32"   # run: curl ifconfig.me - avoid 0.0.0.0/0
   ```
   Only `key_name` and `ssh_allowed_cidr` need real values specific to your environment — the rest can be left as shown, or adjusted as needed.

3. Initialize, review, and apply:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
   ```

4. Get the load balancer's DNS name from the output:
   ```bash
   terraform output alb_dns_name
   ```

---

## Verifying it works

**Basic connectivity:**
```bash
curl http://<alb_dns_name>
```
Should return "Hello World from Web Server 1" or "Web Server 2" — either is correct, since the ALB distributes traffic across both healthy targets.

**Failover test:**
1. In the AWS Console (or via CLI), stop or deregister one of the two EC2 instances.
2. Wait roughly 20–30 seconds for the ALB's health check to detect the failure.
3. Repeat `curl http://<alb_dns_name>` several times — every response should now consistently come from the surviving server, with no failed requests.
4. Restart/re-register the stopped instance, wait for it to pass health checks again, and confirm the ALB resumes distributing traffic across both.

---

## Tearing down

```bash
terraform destroy
```
Run this after each work/testing session rather than leaving the ALB running continuously, since it bills hourly regardless of traffic.

---