<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

| Permission | Machine name | Grants |
|---|---|---|
| Administer Let's Encrypt Challenge | `administer letsencrypt challenge` | Access `/admin/config/letsencrypt_challenge/challenge` to set the stored challenge value |

Defined in `letsencrypt_challenge.permissions.yml` (title only; no `restrict access` flag). It is the
sole requirement on route `letsencrypt_challenge.challenge_form`.

The two `/.well-known/acme-challenge` serving routes carry no permission requirement
(`_access: 'TRUE'`) — they answer anonymous GET requests without authentication, which is what an
ACME validation server needs in order to fetch the challenge. Their response body is only the
`letsencrypt_challenge.challenge` state value.
