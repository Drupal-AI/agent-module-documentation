# Configuration

Setting up Sightengine has two parts: configure the connection and models once on the
settings form, then turn moderation on for each field you want checked.

## 1. Get your API credentials

Create a Sightengine account and obtain the app's **API user** (`client_id`) and **API
secret** (`client_secret`).

## 2. Configure the module

Go to **`/admin/config/people/sightengine`** (permission **administer sightengine**).
The form is organised into sections:

### App information
- **Client ID** and **Client Secret** — your Sightengine credentials (both required).
  The secret is stored in configuration and sent as `api_secret` on every request, so
  keep an eye on who can read your site config.

### Text moderation
- **Text validator URL** — the Sightengine text-moderation endpoint (required).
- **Mode** — `standard` or `username` (use `username` when moderating short handles
  rather than prose).
- **OPT country** — ISO country codes used for phone-number detection in text.
- **Ignore models** — check the detections you do *not* want to flag: profanity
  subtypes (sexual, discriminatory, insult, inappropriate, other), personal-data types
  (email, phone number, IPv4, IPv6), and URL/link detection. Anything you tick here is
  detected but not treated as a violation.

### Image moderation
- **Image validator URL** — the Sightengine image-moderation endpoint.
- **Image models** — choose which to run: **nudity**, **weapons/alcohol/drugs**,
  **gore**, **offensive**.

### Video moderation
- **Video validator URL** — the Sightengine video-moderation endpoint.
- **Video models** — the same set of choices as images, applied to video content.

## 3. Turn moderation on per field

Moderation is opt-in per field:

1. Edit any **string, text, image, file, or entity reference** field (for example under
   **Structure → Content types → *(your type)* → Manage fields**).
2. Tick the **"Sightengine validate"** checkbox the module adds to the field edit form.
3. Save the field.

From then on, that field is checked whenever its entity is saved.

## How validation runs

When an entity with a moderated field is saved, the module builds a request and posts it
to the matching validator URL:

- **Text** fields send the text plus mode, country, and language.
- **Image and file** fields upload the file; media/entity-reference fields resolve to
  the underlying file and route images and videos to the image or video endpoint by
  their type.

If any enabled model's score crosses the threshold (and the detection is not in your
"ignore" lists), the save **fails validation** with a message naming the offending
category — so, for example, a nude avatar upload or an insulting comment is blocked
before it is published. Untick the checkbox on a field to turn its moderation back off.

## Things to keep in mind

- **Validation is synchronous and blocking.** Every save of a moderated field makes an
  outbound API call (text calls allow up to 100 seconds, image calls up to 10), so mind
  latency and your Sightengine quota on high-traffic forms.
- **Tune sensitivity by toggling models, not by editing code** — the underlying score
  threshold is fixed at `0.5` in the module.
- The endpoint URLs are admin-set and never taken from a request, so there is no SSRF
  risk; keep them pointed at the official Sightengine API hosts.
- Check the **`sightengine` log channel** (Reports → Recent log messages) for
  moderation and API errors.
