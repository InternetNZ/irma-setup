# Demo UI

If you face any issues when running your demoui website, you may check some of those tips:

**Certs and hosts**

Check [running on docker](running-on-docker.md) on the section regarding requirements, specially adding certs and hosts.

**Mixed block**

While we are still using IPs on local development you may have some `Mixed block` info when using your demoui 
website. If it happens, you need to remove protection for doing http request at https address.

**Token**

When talking to our local keyshare server, you may use security by `token` with the value defined at your `.env` file. 
Just append a request with a token of your choice:

Ex:

```
IRMASERVER_REQUESTORS='{"keyshare_server":{"auth_method":"publickey","key_file":"/irma/jwtkeys/pk.pem"},"ui":{"auth_method":"token","key":"super-secret-token"}}'
```
