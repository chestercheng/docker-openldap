# OpenLDAP Pass-Trough authentication with SASL

![](https://ltb-project.org/_media/documentation/general/sasl_delegation.png)

ref: https://ltb-project.org/documentation/general/sasl_delegation


# Build

```
$ make build

# no-cache
$ make build-nocache
```


# Test

```
$ make runtest
```


# Run

* Standard alone

    ```
    $ docker run -p 389:389 -p 636:636 docker-openldap
    ```

* Multi master replication

    LDAP servers:

    * ldap1.example.org

    * ldap2.example.org

    ```
    # Create the first ldap server
    docker run -p 389:389 -p 636:636 \
        --env LDAP_HOST="ldap1.example.org" \
        --env LDAP_REPLICATION_HOSTS="ldap1.example.org,ldap2.example.org" \
        docker-openldap

    # Create the second ldap server
    docker run -p 389:389 -p 636:636 \
        --env LDAP_HOST="ldap2.example.org" \
        --env LDAP_REPLICATION_HOSTS="ldap1.example.org,ldap2.example.org" \
        docker-openldap
    ```


# Environment Variables

* ` LDAP_DOMAIN `: LDAP domain. Defaults to ` example.org `

* ` LDAP_BASE_DN `: LDAP base DN. Defaults to ` dc=example,dc=org `

* ` LDAP_ROOT_PW `: LDAP admin password. Defaults to ` adminpassword `

* ` LDAP_BIND_PW `: LDAP read-only user password. Defaults to ` bindpassword `

* ` AD_URI `: Active Directory URI.  Defaults to ` ldap://ad.example.org `

* ` AD_BASE_DN `: AD base DN. Defaults to ` dc=ad,dc=example,dc=org `

* ` AD_BIND_DN `: AD bind user. Defaults to ` cn=bind,dc=ad,dc=example,dc=org `

* ` AD_BIND_PW `: AD bind password. Defaults to ` adbindpassword `

* TLS:

    * ` SSL_CERTS_PATH `: SSL certificate directory. Defaults to` /etc/ldap/assets/certs `

    * ` SSL_CA_CRT_FILENAME `: SSL CA certificate filename. Defaults to ` ca.crt `

    * ` SSL_CRT_FILENAME `: SSL certificate filename. Defaults to ` ldap.crt `

    * ` SSL_KEY_FILENAME `: SSL certificate private key filename. Defaults to ` ldap.key `

    * ` SSL_DH_PARAM_FILENAME `: SSL certificate dh param file. Defaults to ` dhparam.pem `

* Replication:

    * ` LDAP_HOST `: LDAP replication hostname. Default to ` (empty) `

    * ` LDAP_REPLICATION_HOSTS `: List of replication hosts. Default to ` (empty) `
