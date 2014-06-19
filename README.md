ddbnz-rax
=================

Bootstrap scripts and configurations for creating a seamless, autoscaling cloud environment.
Private information such as user logins and API keys has been stripped and replaced with "XXXX"

Steps required to make this work:
1. Seed the required files with the right information for API Keys, usernames and other variables.
The files that need to be seeded are

```Bash
auth_token.json
bootstrap/cloudinit/default/cloudconfig.yaml
bootstrap/cloudinit/default/userscript.sh
bootstrap/cloudinit/nodejs/cloudconfig.yaml
bootstrap/cloudinit/nodejs/userscript.sh
bootstrap/cloudinit/redis/cloudconfig.yaml
bootstrap/cloudinit/redis/userscript.sh
bootstrap/personality/ddbnz-warehouse
bootstrap/personality/raxrc
nova.boot.sh
```
2. Install [httpie](https://github.com/jakubroztocil/httpie) to make life much easier
3. To create servers, use the nova.boot.sh script and copy-paste the relevant bits
4. To modify the Autoscaling groups, first generate a token:
```Bash
http POST https://identity.api.rackspacecloud.com/v2.0/tokens < auth_token.json
# save token:
export TOKEN=^^token (copy-paste with mouse)
```
5. To modify existing things, use the API through httpie:

```Bash
# Create AS group:
http POST https://syd.autoscale.api.rackspacecloud.com/v1.0/${OS_TENANT_NAME}/groups/ X-Auth-Token:$TOKEN < example.policy.json
```
