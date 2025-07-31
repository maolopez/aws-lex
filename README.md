# aws-lex
terraform deploying AWS Lex and additional related infrastructure

-If you want to use pre-trained Comprehend models for sentiment analysis or entity recognition, you don't need to create a separate Comprehend model. Lex will handle it for you.


-If you want to use a custom Comprehend model, you'll need to create and deploy it separately and integrate it with your Lex bot using a Lambda function.


INSTRUCTIONS
------------------

cd aws-lex/app/

terraform init

terraform validate

terraform plan  #More info in app/terraform_plan.txt

terraform apply auto-approve


EXPECTATIONS
------------------

You can view the infrastructure created by Terraform in the AWS Management Console. Here are the specific locations to check for each resource:



REFERENCES
------------------

https://github.com/maolopez/aws-comprehend

https://github.com/maolopez/aws-capstone-kubernetes-mgl

https://github.com/maolopez/aws-capstone-pipeline-mgl

https://github.com/maolopez/aws-capstone