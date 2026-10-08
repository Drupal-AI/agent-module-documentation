<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform OpenFisca — agent index

**Adds OpenFisca support for RaC-enabled webforms** (rules-as-code eligibility/benefit evaluation). Depends on core
`options`, `webform`, `paragraphs`, `token`. Version **1.1.3**. Core `^10||^11||^12`.

Forms/integration — **sends form data to an OpenFisca API** (egress; can include sensitive personal/financial data
— disclose); credentials as secrets, HTTPS. No access role.
