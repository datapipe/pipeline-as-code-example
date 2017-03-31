## CI/CD Pipeline-as-code example

Accompanying blog post: https://www.datapipe.com/blog/2017/03/30/cicd-pipelines-as-code/

This is an example repository to highlight the basic value of pipelines-as-code using Jenkins and Terraform.

The Terraform stack (`main.tf`), consists of a single Auto-Scaling Group + Launch Configuration for a single Ubuntu instance.  Customize the `variables.tf` file accordingly.  A Default VPC is assumed to be present in the target region.
