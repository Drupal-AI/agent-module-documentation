# Permissions

Defined in `google_reviews.permissions.yml`.

| Permission | Title | Gates |
|---|---|---|
| `google_reviews admin` | Google reviews module admin | The settings form route `google_reviews.review_settings` (`/admin/review-settings`) **and** the fetch route `google_reviews.add_reviews` (`/reviews`). |

Both module routes list `_permission: 'google_reviews admin'` as their only
requirement. The permission is **not** marked `restrict access: true`, so grant it only
to trusted roles (it exposes the API key on the settings form and triggers billed Google
API calls).

Grant via Drush:

```bash
drush role:perm:add administrator 'google_reviews admin' -y
```

The block itself, the `review` content type, and node create/edit are governed by core
`node`/`block` permissions, not by this module.
