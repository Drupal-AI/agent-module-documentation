# login_emailusername — agent start

Lets users log in with EITHER username OR email in the same login box, and accepts
email on the REST login/password-reset endpoints. Keeps the username field (unlike
`email_registration`). Depends only on core `user`; requires `^10.3 || ^11.0`.
**No settings, no permissions, no configure route — enabling the module is all it takes.**

- Set up, behavior, how email→username resolution works, REST endpoints → [configure/login_emailusername.md](configure/login_emailusername.md)
