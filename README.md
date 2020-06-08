# Lambda in VPC access to Internet

It took me a while to sort out the network setup for a NAT Gateway and subnets to get a lambda to talk to external services (particularly sentry) while being able to connect to RDS. Have seen other people struggling, so sharing it here. 

Based on the best instructions I could find for this setup: https://gist.github.com/reggi/dc5f2620b7b4f515e68e46255ac042a7

Work originally done for WeGotPOP Ltd, shared with authorization.

## Notes/limitations

* While this code covers the case of 3 availability zones, you might need to adjust it for regions with 2 or 4 availability zones (or submit a pull-request for dealing with that).
* It also only sets up one NAT Gateway, you might want more resilience than that (this was done because of costs).
* This code assumes that the public network already has an Internet Gateway setup for it. If that's not your case, you'll have to set it up.

## Cost

This code creates a NAT gateway, so it will add to your AWS bill. Check the cost in https://aws.amazon.com/vpc/pricing/#natgatewaypricing, as it has an hourly charge, a data charge and it can also add up to the EC2 data out charges.

## Inputs
 - vpc_id - the VPC ID of the VPC where the lambda is/is going to be set up.
 - Private network setup:
   - az_lambda_1/az_lambda_2/az_lambda_3 - the availability zones the lambda will be deployed in.
   - cidr_lambda_1/cidr_lambda_2/cidr_lambda_3 - a CIDR network range for each subnet (one per availability zone). Don't make this small as it can limit the amount of lambdas that can be run.
 - Public network setup:
   - az_nat_1 - availability zone for the public network.
   - cidr_nat_1 - CIDR network for the public subnet.

## Example usage
```
module "lambda_vpc_internet_access" {
    source = "modules/lambda-vpc-internet-access"

    vpc_id = "vpc-XXXXXXX"
    az_lambda_1 = "eu-west-1a"
    cidr_lambda_1 = "172.31.64.0/20"
    az_lambda_2 = "eu-west-1b"
    cidr_lambda_2 = "172.31.96.0/20"
    az_lambda_3 = "eu-west-1c"
    cidr_lambda_3 = "172.31.128.0/20"
    az_nat_1 = "eu-west-1c"
    cidr_nat_1 = "172.31.160.0/20"
}
```

Then you'll have available for your lambda subnets the following IDs:

```
module.lambda_vpc_internet_access.subnet_lambda_1
module.lambda_vpc_internet_access.subnet_lambda_2
module.lambda_vpc_internet_access.subnet_lambda_3
```

## Copyright/License

This software is copyrighted by WeGotPOP Ltd. and distributed under the MPL - Mozilla Public License 2.0 

You can read the terms of the license in https://www.mozilla.org/en-US/MPL/2.0/
