<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Server-side A/B Testing runs experiments with node variants, assigned and cached server-side.

---

Server-side A/B Testing provides a server-side A/B testing framework for Drupal using node-based variants — visitors are assigned a variant on the server (cache-aware) so experiments work with page caching, avoiding the flicker and cache issues of client-side A/B testing. Editors define experiments and variants as content.

It exposes permissions for experiment administration, settings, reset, variant preview, and a `bypass server-side ab testing` permission — restrict administration/bypass to trusted roles. Depends on core `node` and `user`; supports Drupal 10 and 11.

---

- Run server-side A/B tests.
- Use node-based variants.
- Assign variants on the server.
- Be cache-aware.
- Avoid client-side flicker.
- Work with page caching.
- Gate admin with `administer server-side ab experiments`.
- Gate settings/reset permissions.
- Offer `preview server-side ab variants`.
- Offer `bypass server-side ab testing`.
- Restrict admin/bypass to trusted roles.
- Depend on core `node` and `user`.
- Support Drupal 10 and 11.
- Define experiments as content.
- Test content variants.
- Measure variant performance
- Support experimentation
- Preview variants
