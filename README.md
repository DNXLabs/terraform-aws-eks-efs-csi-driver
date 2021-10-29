# terraform-aws-eks-efs-csi-driver

[![Lint Status](https://github.com/DNXLabs/terraform-aws-eks-efs-csi-driver/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-eks-efs-csi-driver/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-eks-efs-csi-driver)](https://github.com/DNXLabs/terraform-aws-eks-efs-csi-driver/blob/master/LICENSE)

Terraform module for deploying [aws-efs-csi-driver](https://github.com/kubernetes-sigs/aws-efs-csi-driver)  inside a pre-existing EKS cluster.

The [Amazon Elastic File System](https://aws.amazon.com/efs/) Container Storage Interface (CSI) Driver implements the [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) specification for container orchestrators to manage the lifecycle of Amazon EFS file systems.

## Usage
```
module "efs_csi_driver" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-efs-csi-driver.git"

  cluster_name                     = module.eks_cluster.cluster_id
  cluster_identity_oidc_issuer     = module.eks_cluster.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks_cluster.oidc_provider_arn
}
```

## Examples
Before the example, you need to:

- Get yourself familiar with how to setup Kubernetes on AWS and how to create EFS file system.
- When creating EFS file system, make sure it is accessible from Kubernetes cluster. This can be achieved by creating the file system inside the same VPC as Kubernetes cluster or using VPC peering.
- Install EFS CSI driver using this module.

#### Example links
- [Static provisioning](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/static_provisioning/README.md)
- [Dynamic provisioning](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/dynamic_provisioning/README.md)
- [Encryption in transit](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/encryption_in_transit/README.md)
- [Accessing the file system from multiple pods](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/multiple_pods/README.md)
- [Consume EFS in StatefulSets](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/statefulset/README.md)
- [Mount subpath](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/volume_path/README.md)
- [Use Access Points](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/access_points/README.md)

## Encryption In Transit

One of the advantages of using EFS is that it provides [encryption in transit](https://aws.amazon.com/blogs/aws/new-encryption-of-data-in-transit-for-amazon-efs/) support using TLS. Using encryption in transit, data will be encrypted during its transition over the network to the EFS service. This provides an extra layer of defence-in-depth for applications that requires strict security compliance.

Encryption in transit is enabled by default in the master branch version of the driver. To disable it and mount volumes using plain NFSv4, set volumeAttributes field encryptInTransit to "false" in your persistent volume manifest. For an example manifest, see [Encryption in Transit Example](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/encryption_in_transit/specs/pv.yaml).

> Note Kubernetes version 1.13+ is required if you are using this feature in Kubernetes.



<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.13, < 4.0 |
| helm | >= 1.0, < 3.0 |
| kubectl | >= 1.9.4 |
| kubernetes | >= 1.10.0, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0, < 3.0 |
| kubectl | >= 1.9.4 |
| kubernetes | >= 1.10.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_namespace | Whether to create k8s namespace with name defined by `namespace`. | `bool` | `true` | no |
| create\_storage\_class | Whether to create Storage class for EFS CSI driver. | `bool` | `true` | no |
| enabled | n/a | `bool` | `true` | no |
| helm\_chart\_name | Amazon EFS CSI Driver chart name. | `string` | `"aws-efs-csi-driver"` | no |
| helm\_chart\_release\_name | Amazon EFS CSI Driver release name. | `string` | `"aws-efs-csi-driver"` | no |
| helm\_chart\_repo | Amazon EFS CSI Driver repository name. | `string` | `"https://kubernetes-sigs.github.io/aws-efs-csi-driver/"` | no |
| helm\_chart\_version | Amazon EFS CSI Driver chart version. | `string` | `"2.2.0"` | no |
| mod\_dependency | Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable. | `any` | `null` | no |
| namespace | Kubernetes namespace to deploy EKS Spot termination handler Helm chart. | `string` | `"kube-system"` | no |
| service\_account\_name | Amazon EFS CSI Driver service account name. | `string` | `"aws-efs-csi-driver"` | no |
| settings | Additional settings which will be passed to the Helm chart values, see https://github.com/kubernetes-sigs/aws-efs-csi-driver. | `map` | `{}` | no |
| storage\_class\_name | Storage class name for EFS CSI driver. | `string` | `"efs-sc"` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eks-efs-csi-driver/blob/master/LICENSE) for full details.
