/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

variable "vpc_id" {
    type = string
    default = ""
}

variable "cidr_lambda_1" {
    type = string
    default = ""
}

variable "cidr_lambda_2" {
    type = string
    default = ""
}

variable "cidr_lambda_3" {
    type = string
    default = ""
}

variable "cidr_nat_1" {
    type = string
    default = ""
}

variable "az_lambda_1" {
    type = string
    default = ""
}

variable "az_lambda_2" {
    type = string
    default = ""
}

variable "az_lambda_3" {
    type = string
    default = ""
}

variable "az_nat_1" {
    type = string
    default = ""
}
