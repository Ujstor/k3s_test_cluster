## K3s Hetzner test cluster
Before you begin, ensure you have the following:

- A Hetzner Cloud account. You can sign up for one [here](https://hetzner.cloud/?ref=Ix9xCKNxJriM).
- The following command-line tools installed:
  - [Terraform](https://www.terraform.io/downloads.html)
  - [Packer](https://www.packer.io/downloads)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  - [hcloud CLI](https://github.com/hetznercloud/cli)

## Deployment Steps

### 1. Generate SSH Keys
Generate a passphrase-less SSH key pair to be used for the cluster.

```shell
ssh-keygen -t ed25519 -N "" -f ~/.ssh/test_k3s_cluster
```

### 2. Create MicroOS Snapshot
- Create a project in your Hetzner Cloud Console and obtain an API key with "Read & Write" permissions.
- Navigate to the directory where you want to deploy the cluster and execute the following command to create required MicroOS snapshot on Hetzner Cloud:


```shell
tmp_script=$(mktemp) && curl -sSL -o "${tmp_script}" https://raw.githubusercontent.com/kube-hetzner/terraform-hcloud-kube-hetzner/master/scripts/create.sh && chmod +x "${tmp_script}" && "${tmp_script}" && rm "${tmp_script}"
```
The command will also download kube.tf, where you can see the full configuration possibilities.
Rename it with .example or delete it because files in the repository contain configurations for the cluster.

### 3. Terraform
Initialize Terraform and apply the configuration:

```bash
terraform init
terraform validate
terraform apply
```

### 4. Kube config
Once the cluster is deployed, you can access and manage it:

  ```shell
  terraform output kubeconfig
  ```
