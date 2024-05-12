# Terraform - Set up using amazon aws

## 1. create an aws account
## 2. create a use group [grant specific rights to it - AdministratorAccess- For the purpose of learning]
- Note in real world projects, you will need to specify the access rights of the user group so as not to grant one user, unfiltered access to your aws account
## 3. create a user and assign the user group to it. This user should have programmatic access enabled
- Ensure to download the security key file

## 4. create the `main.tf` example in terraform directory

## 5. Setting up access for aws on the cli - by exporting
```bash
export AWS_ACCESS_KEY_ID=<KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET_KEY>
```

## 6. initialize terraform in the work directory
```bash
terraform init
```

## 7. run the plan command to see what will do before making any changes
```bash
terraform plan
```

## 8. Deploy terraform 

```bash
terraform apply
```