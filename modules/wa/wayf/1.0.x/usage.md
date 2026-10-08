<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SAML federated login via the WAYF (Where Are You From) service.

---

WAYF Login implements the WAYF login service — a SAML 2.0 Service Provider integration for the WAYF (Where Are You From) identity federation (Danish/Nordic research & education), so users authenticate via their institution's SAML IdP and are logged into Drupal.

The SAML assertion is signature-verified in the consume/ACS endpoint (`SPorto::verifySignature`) before login; configure the SP/IdP metadata and certificates carefully. Supports Drupal 10 and 11.

---

- Implement WAYF SAML login.
- Act as a SAML 2.0 SP.
- Authenticate via institution IdPs.
- Verify the assertion signature.
- Serve research/education federations.
- Configure SP/IdP metadata.
- Support Drupal 10 and 11.
- Handle the ACS endpoint.
- Enable federated SSO.
- Handle WAYF.
- Log users in.
- Federate identity
- Support Drupal.
- Support Drupal.
- Support Drupal.
