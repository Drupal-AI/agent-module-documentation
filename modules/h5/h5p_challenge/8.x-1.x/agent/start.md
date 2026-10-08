<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# H5P Challenge (h5p_challenge) — agent index

**Turns any H5P content into a code-joined scoring challenge with xAPI results, leaderboards, CSV export and email notices.**

- **Version:** 8.x-1.x  •  core: `^10.2 || ^11`  •  php 8.1  •  depends on `h5p:h5p`  •  package: H5P
- **Configure:** `/admin/config/system/h5p_challenge` (perm *access administration pages*). Reports: `/admin/reports/h5p_challenge`.
- **Gameplay JSON routes (`_access: TRUE`):** `h5p_challenge/create-new.json`, `start-playing.json`, `set-finished.json`, `settings.json`, `{challenge}/results`, `{challenge}/results/csv`.
- **User routes:** `h5p_challenge/mine` (`_user_is_logged_in`); `{challenge}/end` & `{challenge}/delete` (`_custom_access`).
- **Service:** `h5p.challenge.default` (`H5PChallengeService`). Tables: `h5p_challenge`, `h5p_challenge_points`.
- **Submodule:** `h5p_challenge_rest` (needs `rest`) — read REST resources, e.g. `api/h5p_challenge/challenge/{uuid}/results` (paginated, from/until).

**Access:** gameplay endpoints are intentionally anonymous (`_access: TRUE`) and reCAPTCHA-guard challenge creation (server-side siteverify). They require a non-empty `token` GET param. Admin/config/report routes permission-gated.

See [configure/settings.md](configure/settings.md) and [api/endpoints.md](api/endpoints.md)
