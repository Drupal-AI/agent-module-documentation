BlueSky Integration connects Drupal to the BlueSky (AT Protocol) social network so sites can compose and publish posts programmatically, primarily through ECA workflows.

---

The module is a thin Drupal wrapper around the `potibm/phluesky` PHP library. It stores a single BlueSky account (a handle plus an app password held in a Key entity), exposes a `bsky.post_service` service that builds and sends posts, and ships four ECA action plugins — Create Post, Add Facets, Add Image, Send Post — that let a no-code ECA model assemble a post step by step and publish it to BlueSky using the configured credentials. It is deliberately minimal: it provides the API connection and building blocks for other modules or ECA models rather than a full posting UI. The library performs facet parsing (turning @-handles, hashtags and URLs into rich links), image upload and the actual authenticated AT Protocol record creation.

---

- Automatically cross-post new nodes to a BlueSky account when content is published.
- Announce blog posts or news articles to BlueSky via an ECA model triggered on node insert/update.
- Post a message to BlueSky on a schedule using ECA plus a cron/scheduler trigger.
- Publish a promotional message with a clickable link (facet) back to the source page.
- Turn plain hashtags in a message into real BlueSky hashtag links using the Add Facets action.
- Convert @-mentions in a message into linked BlueSky handles automatically.
- Attach a featured image (with alt text) from a node's image field to an outgoing post.
- Post an image-only or image-plus-text update from a media/file field.
- Build a post body from entity tokens (e.g. `[node:title]` + `[node:url]`) before sending.
- Send a website "card" preview (URL, title, description, optional image) for a shared link.
- Route the response of a send (status, headers, JSON body, client_error flag) into an ECA token for follow-up logic.
- Branch an ECA model on the BlueSky send result — e.g. log or retry when `client_error` is set.
- Notify followers of an event or product launch from a Drupal Webform submission via ECA.
- Provide a reusable `bsky.post_service` for custom modules that need to post to BlueSky in PHP.
- Centralize BlueSky credentials in the Key module so the app password is not stored in exported config.
- Let non-developers wire up BlueSky posting entirely in the ECA UI without writing code.
- Compose a multi-step post (create → add facets → add image → send) as discrete, reorderable ECA actions.
- Post links to newly indexed content, with the link rendered as a rich facet rather than plain text.
- Integrate BlueSky posting into an existing multichannel publishing ECA model alongside other social actions.
- Test connectivity by configuring the handle and app key at Admin → Configuration → Web Services → BlueSky Settings.
- Reuse an image style URL as the image source for a post when the derivative is already generated.
