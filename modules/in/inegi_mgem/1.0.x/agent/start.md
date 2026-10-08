<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# INEGI MGEM Integration (inegi_mgem) — agent index

**Blocks that query Mexico's public INEGI geo-statistical web service (AGEE/AGEM) to display state, municipality and locality records by key.**

- **Version:** 1.0.x — core `^10 || ^11`; depends on `block`
- **Services:** `inegi_mgem.client` (`InegiClientService`), `inegi_mgem.municipal_locality_client` — HTTPS calls to `gaia.inegi.org.mx/wscatgeo/v2/{mgem,lgev}/` with a 5s timeout.
- **UI:** two block plugins (State lookup, Municipal/Locality lookup) configured with `cve_ent`/`cve_mun`/`cve_loc`; placed via Block layout.
- **Security:** no routes, no permissions, no auth/secrets (INEGI API is public); outbound HTTPS with default TLS verification. No security findings.
