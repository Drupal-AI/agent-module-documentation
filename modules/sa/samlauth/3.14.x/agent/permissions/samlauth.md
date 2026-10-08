# Permissions

Defined in `samlauth.permissions.yml`.

| Permission | Gates |
|---|---|
| `configure saml` | All SAML admin forms — the two config forms at `/admin/config/people/saml` and `/admin/config/people/saml/saml`, the authmap-delete form, and (via the submodules) the user-field and user-role mapping forms. Marked `restrict access: TRUE` (trusted/administrative). |
| `view sp metadata` | Access to the SP metadata XML at `/saml/metadata`. Grant temporarily/publicly so the IdP administrator can fetch metadata. |

The `/saml/login`, `/saml/acs`, `/saml/sls`, `/saml/logout`, `/saml/reauth`, `/saml/changepw`
routes are not gated by a samlauth permission — access is controlled by login state
(`_user_is_logged_in`) and the SAML message validation itself.

```
drush role:perm:add saml_admin 'configure saml'
drush role:perm:add anonymous 'view sp metadata'   # e.g. while onboarding the IdP
```
