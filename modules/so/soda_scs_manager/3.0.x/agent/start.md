<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SODa SCS manager (soda_scs_manager) — agent index

**Self-service provisioning of containerised research stacks/components (Portainer/Docker, Keycloak, Nextcloud, triplestores) modelled as Drupal entities.**

- **Version:** 3.0.x
- **Core:** ^10 | ^11
- **Dependencies:** language, openid_connect, smtp, field_group, soda_scs_manager_theme
- **Configure:** `/admin/config/soda-scs-manager/settings` (`soda scs manager admin`)
- **Entities:** soda_scs_stack, soda_scs_component, soda_scs_snapshot, soda_scs_service_key, soda_scs_project
- **Key permissions:** `soda scs manager user` (own resources), `soda scs manager admin` (settings/keys/debug/updates)
- **Notable routes:** health/progress checks, docker exec/run via RequestActions, service-link, Keycloak registration/approval
- **Security:** Reviewed. The only `_access: 'TRUE'` route is `soda_scs_manager.user_registration` (`/user/register`) — it just inserts a *pending* row into `keycloak_user_registration` for admin approval, no anonymous provisioning. Mutating/provisioning routes require `soda scs manager user`/`admin` and owner-scoped custom access handlers. No disabled TLS, no hardcoded secrets (Portainer/Keycloak/Nextcloud creds come from config/Key/Service-Key entities). No security findings.

See [configure/settings.md](configure/settings.md) and [api/actions.md](api/actions.md)
