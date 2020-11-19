variable "names" {
  description = "names to be applied to resources"
  type        = map(string)
}

variable "location" {
    type        = string
    description = "Azure Geo Location"
}

variable "account_kind" {
    type        = string
    description = "Kind of the storage account - i.e. BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
}

variable "account_tier" {
    type        = string
    description = "Azure storage account - i.e. Standard or Premium"
}

variable "replication_type" {
    type        = string
    description = "Storage account replication type - i.e. LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS"
}

variable "access_tier" {
    type        = string
    description = "Storage access tier - i.e. Hot or Cool"
}

variable "allow_blob_public_access" {
    type        = bool
    description = "Allow or disallow public access to all blobs or containers in the storage account. Defaults to false"
}

# Note: make sure to include the IP address of the host from where "terraform" command is executed to allow for access to the storage
# Otherwise, creating container inside the storage or any access attempt will be denied.
variable "authorized_subnets" {
  type = map(string)
  description = "A list of subnets that will be allowed to interact with the Storage Account."
}

variable "tags" {
  type = map
}

variable "retention_days" {
    type    = number
    default = 7
    description = "Retention days for deleted blob. Valid value is between 1 and 365."
}
