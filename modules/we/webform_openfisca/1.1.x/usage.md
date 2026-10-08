<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform OpenFisca adds OpenFisca (rules-as-code) support to webforms.

---

Webform OpenFisca **adds OpenFisca support to webforms** — connecting Rules-as-Code (RaC) enabled webforms to
an OpenFisca engine so form inputs are evaluated against benefit/tax/eligibility rules and results returned. It
depends on core Options, the Webform, Paragraphs and Token modules.

Use it to run eligibility/benefit calculations from forms. It is a forms/integration feature. Security/data
handling: it **sends form data to an OpenFisca API** (external egress — form data can include **sensitive personal/
financial information**; confirm acceptable and disclose per policy), and any API credentials should be secrets over
HTTPS. It has no access-control role. Configure the OpenFisca endpoint.

---

- Add OpenFisca support to webforms.
- Evaluate rules-as-code.
- Return benefit/tax/eligibility results.
- Depend on Webform + Paragraphs + Token.
- Serve forms/integration.
- Run rule evaluations.
- Send form data to an OpenFisca API (egress; sensitive personal/financial data).
- Confirm acceptable + disclose per policy.
- Store any API credentials as secrets over HTTPS.
- Have no access-control role.
- Configure the OpenFisca endpoint.
- Handle OpenFisca.
- Evaluate rules.
- Configure the endpoint.
- Send form data.
- Handle the integration.
- Calculate eligibility.
- Return results.
- Secure the endpoint.
- Provide OpenFisca support.
