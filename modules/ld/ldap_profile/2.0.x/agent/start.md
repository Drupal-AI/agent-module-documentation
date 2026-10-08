<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LDAP Profile — agent index

Extends **LDAP user mapping to Profile fields** for LDAP-identified users (sync extra directory attributes into
the Drupal profile). Depends on `ldap_user`. Version **2.x** (dev). Core `^8.9||^9||^10||^11`.

Auth/directory integration — connection handled by the LDAP suite: use **LDAPS/StartTLS**, store **bind
credentials** as secrets (directory data is sensitive). Maps attributes; no access role of its own.
