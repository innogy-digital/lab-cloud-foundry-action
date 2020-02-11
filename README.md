# Cloud Foundry CLI Action

Wraps the Cloud foundry CLI to enable CF commands over a ssh proxy.

## Inputs

### `sshProxyServer`
**Required** Server for the ssh server.

### `sshProxyUser`
**Required** Username for the ssh server.

### `sshProxyPem`
**Required** PEM for the ssh server.

### `proxyPem`
**Required** PEM for PCF Proxy.

### `cfApi`
**Required** CF API Endpoint.

### `cfOrg`
**Required** CF Org.

### `cfSpace`
**Required** CF Space.

### `cfUsername`
**Required** CF Username.

### `cfPassword`
**Required** CF Password.

### `cfArgs`
**Required** CF args.

## Outputs

## Example usage

```yaml
uses: innogy-digital/lab-cloud-foundry-action@master
with:
  sshProxyServer: 'XXX.XXX.XXX.XXX'
  sshProxyUser: 'some-user'
  sshProxyPem: 'XYZ'
  cfApi: 'https://api.sys.mila.ap.innogy.com'
  cfOrg: 'XYZ'
  cfSpace: 'XYZ'
  cfUsername: 'XYZ'
  cfPassword: 'XYZ'
  cfArgs: 'push app-name'

```
