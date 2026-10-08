<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Donate embeds donation forms from multiple donation providers, part of the Open Y (YMCA) distribution, with a Layout Builder donate block.

---

YMCA and nonprofit sites take donations through various providers. Y Donate embeds donation forms from multiple providers, with an `lb_donate` Layout Builder block, part of the Open Y distribution. It embeds third-party donation forms/scripts, which is the consideration: donation forms handle money and personal/financial data, so the embedded provider's security applies (card handling should be on the provider, not the Drupal server — reducing PCI scope), the provider's script is a third-party origin (and may track), and any provider API keys/config are credentials to protect. For a YMCA/nonprofit site it provides a multi-provider donation embed; confirm each provider's integration keeps card data off your server and configure credentials securely.

---

- Embed donation forms.
- Take donations from multiple providers.
- Add a donate block.
- Embed a provider's form.
- Keep card data off the server.
- Protect provider credentials.
- Gate provider scripts behind consent.
- Use the Layout Builder donate block.
- Support a nonprofit site.
- Handle donation data carefully.
- Configure donation providers.
- Adopt with Open Y.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.