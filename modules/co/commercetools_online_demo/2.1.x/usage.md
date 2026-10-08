<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zero-click commercetools demo with a pre-configured B2C Lifestyle store.

---

commercetools Online Demo spins up a zero-click commercetools demo — a pre-configured B2C Lifestyle store — on top of the commercetools base integration, so evaluators can see a working commercetools-backed storefront without manual setup. It's a demo/showcase module (not for production). Depends on the commercetools suite (`commercetools`, `commercetools_demo`, `commercetools_content`, `commercetools_decoupled`) plus core `content_translation` and `locale`; supports Drupal 9, 10, and 11.

---

- Provide a zero-click commercetools demo.
- Ship a pre-configured B2C Lifestyle store.
- Showcase a commercetools storefront.
- Avoid manual setup.
- Serve evaluation/demo use.
- Not run in production.
- Build on the commercetools suite.
- Depend on `commercetools`, `commercetools_demo`, `commercetools_content`, `commercetools_decoupled`.
- Require `content_translation` and `locale`.
- Support Drupal 9, 10, and 11.
- Demo headless commerce.
- Configure everything from a single `hook_install` (themes, site name, logo/favicon, demo credentials, front page).
- Deploy the shared `demo1_b2c_lifestyle` account via the commercetools_demo deployer.
