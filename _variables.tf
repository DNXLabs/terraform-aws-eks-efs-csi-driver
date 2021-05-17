variable "enabled" {
  type    = bool
  default = true
}

variable "helm_chart_name" {
  type        = string
  default     = "aws-efs-csi-driver"
  description = "Amazon EFS CSI Driver chart name."
}

variable "helm_chart_release_name" {
  type        = string
  default     = "aws-efs-csi-driver"
  description = "Amazon EFS CSI Driver release name."
}

variable "helm_chart_repo" {
  type        = string
  default     = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  description = "Amazon EFS CSI Driver repository name."
}

variable "helm_chart_version" {
  type        = string
  default     = "1.2.4"
  description = "Amazon EFS CSI Driver chart version."
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create k8s namespace with name defined by `namespace`."
}

variable "namespace" {
  type        = string
  default     = "aws-efs-csi-driver"
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
}

variable "service_account_name" {
  type        = string
  default     = "aws-efs-csi-driver"
  description = "Amazon EFS CSI Driver service account name."
}

variable "storage_class_name" {
  type        = string
  default     = "efs-sc"
  description = "Storage class name for EFS CSI driver."
}

variable "create_storage_class" {
  type        = bool
  default     = true
  description = "Whether to create Storage class for EFS CSI driver."
}

variable "mod_dependency" {
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable."
}

variable "settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, see https://github.com/kubernetes-sigs/aws-efs-csi-driver."
}