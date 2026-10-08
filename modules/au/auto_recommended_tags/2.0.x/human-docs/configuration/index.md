# Configuration

Auto Recommend Content Tags has one settings form, where you tell it how to reach
your Apache Stanbol server.

## Open the settings form

1. Log in as a user with the **`administer auto recommended tags settings`**
   permission. Grant this only to the roles that configure the integration.
2. Go to **Configuration → Web services → Auto Recommended Tags**, or navigate
   directly to `/admin/config/services/auto_recommended_tags`.

## Settings

The form (`AutoRecommendedTagsSettingsForm`) stores the connection details for
the Apache Stanbol service — the Stanbol host / endpoint and the WebSocket bridge
the front-end JavaScript connects to for streaming tag suggestions.

Point these at your own Stanbol host. The site and the editor's browser need
network access to that endpoint, so make sure any firewall or proxy allows the
WebSocket connection.

## After saving

- Test the WebSocket connection so you know suggestions can actually stream back.
- Open a content form and start typing: recommended tags should appear in real
  time, drawn from Stanbol's enhancement engines. Editors choose which
  suggestions to apply to the taxonomy reference field.

## Notes

- Suggestions are **advisory** — nothing is tagged automatically; the editor
  decides.
- A **curated taxonomy vocabulary** gives the best results.
- Because content text is sent to the Stanbol server for analysis, use a Stanbol
  host you trust with that content.
