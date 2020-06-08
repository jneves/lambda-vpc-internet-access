/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */


output "subnet_lambda_1" {
  value = "${aws_subnet.lambda_to_nat_1.id}"
}

output "subnet_lambda_2" {
  value = "${aws_subnet.lambda_to_nat_2.id}"
}

output "subnet_lambda_3" {
  value = "${aws_subnet.lambda_to_nat_3.id}"
}
