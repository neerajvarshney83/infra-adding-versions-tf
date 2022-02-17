# aws-vpn
## intro
aws-vpn is used to deploy a VPN for a private Kubernetes topology, as a single point of external access.

In order to use it, you must obtain SAML IdP metadata (eg. [from Google](https://benincosa.com/?p=3787)) and complete additional setup for each endpoint used.

## inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account | target account alias used in DNS - eg. `dev`, `prod` | `string` | n/a | yes |
| domain | target tld - eg. `fakebank.com` | `string` | n/a | yes |
| environment | target environment - eg `int`, `qa` | `string` | n/a | yes |
| saml\_provider\_arn | provider arn for saml integration | `any` | n/a | yes |
