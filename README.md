## Riot.im
#### Prereqs
1. Generate DO API access key
2. Enable private space in DO and generate space key
3. Create a file `secrets.sh`:

```
#!/bin/bash

export TF_VAR_do_token="[do token]"
export TF_VAR_do_spaces_access_token="[space access token]"
export TF_VAR_do_spaces_secret_key="[space secret key]"
export TF_VAR_do_space_bucket_name="[bucket name]"
```

#### Todo:
1. create ssh key, upload to digital ocean, attach that key to the instance
1. get the IP address of the droplet and pass to ansible