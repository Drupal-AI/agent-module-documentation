# Configuration

Open ReadSpeaker has two parts you configure: the **global settings form** (your
account details and the whole ReadSpeaker reader configuration) and the
**"Listen" block** (where the button appears and which page region it reads).

## Open the settings form

1. Log in as a user with the **Administer open readspeaker** permission (an
   administrator by default).
2. Go to **Configuration → Services → Open ReadSpeaker**, or navigate directly
   to `/admin/config/services/open-readspeaker`.

## Account and connection settings

These top fields tell the module which ReadSpeaker account to use and where to
load the service from:

- **Customer ID** — your ReadSpeaker account identifier. This is **required**;
  if it is empty, the *"Listen"* block shows a warning and renders nothing.
- **CDN** — the ReadSpeaker CDN region closest to your users. Choose from the
  regional options (Europe, Middle East, Africa, Asia, Oceania, East Asia, North
  America, South America). This feeds the CDN token used in the script URL.
- **Language** — the ReadSpeaker reading language (validated against
  ReadSpeaker's list of supported languages).
- **Voice** — an optional named voice. Leave it blank to use ReadSpeaker's
  default for the chosen language.
- **URL** — the remote ReadSpeaker JavaScript URL. It is pre‑filled with a
  **tokenized** default
  (`//cdn-[open-readspeaker:cdn].readspeaker.com/script/[open-readspeaker:customer-id]/webReader/webReader.js?pids=wr`)
  so it automatically uses your customer ID and CDN region. You normally never
  need to change this. The module defines the `[open-readspeaker:customer-id]`
  and `[open-readspeaker:cdn]` tokens; install the Token module if you want a
  browsable token picker on the form.

## The ReadSpeaker reader options (`rsConf`)

The bulk of the form mirrors ReadSpeaker's own `rsConf` configuration object,
grouped into three areas. Every field maps 1:1 to a ReadSpeaker setting, so
ReadSpeaker's own documentation is the authority on what each does. In brief:

- **General behaviour** — site‑wide options such as the reading speed default,
  a cookie name and lifetime for remembering a visitor's voice/settings, the
  translation target languages offered, the highlight‑on‑selection popup and its
  close timing, whether hidden content is skipped, and a POST mode
  (**usePost**) that lets ReadSpeaker read password‑protected pages (required
  when "skip hidden content" is on). There is also an **ignore selector** list —
  comma‑separated HTML attribute names to exclude from being read.
- **Reader defaults** — the per‑visitor browser defaults: highlighting mode
  (word, sentence, or both), highlight colours (word / sentence / text) as hex
  values, whether the highlight icon and auto‑scroll are on, the reading speed,
  and the full **keyboard‑shortcut map** (play, pause, stop, settings,
  translation, enlarge, font size, page mask, and so on) which you can rebind.
- **User interface** — where the floating control panel sits (top/bottom,
  left/right), a mobile menu vertical offset, and a set of checkboxes toggling
  each individual **toolbar tool** on or off (settings, voice settings,
  click‑to‑listen, enlarge, form reading, text mode, page mask, download, help,
  dictionary, translation, skip buttons, speed button, control panel).

Click **Save configuration** when done. The admin‑facing settings can also be
translated with the Config Translation module.

## Place the "Listen" block

The button that visitors actually see is a block:

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Find a region and click **Place block**, then choose **Open ReadSpeaker:
   Webreader**.
3. Configure the block's own settings (below), set any **visibility**
   conditions to limit it to the content types or pages you want, and save.

### Block settings

- **Button text** — the visible label on the button. Default **Listen**.
- **Button title** — the hover/`title` text. Default *"Listen to this page using
  ReadSpeaker"*.
- **Reading area** — the HTML **id** of the page region ReadSpeaker should read
  aloud (default `block-olivero-content`, which targets the main content region
  of the Olivero theme). Set this to the id of whatever region you want read.
  **Required.**
- **Reading area class** — optionally, a comma‑separated list of CSS classes to
  read instead of / in addition to the id (`class1,class2`).
- **URL** — the ReadSpeaker request endpoint, pre‑filled with a tokenized
  default (`//app-[open-readspeaker:cdn].readspeaker.com/cgi-bin/rsent`). Like
  the global script URL, you normally leave this as‑is. **Required.**

Once the block is placed and your customer ID is set, the *"Listen"* button
appears wherever the block's visibility rules allow, and clicking it starts
ReadSpeaker reading the configured region.

## A note on trust and security

The script URL and the block's request URL are entered by an administrator and
cause a third‑party ReadSpeaker script/request to load on every page carrying
the block. Only users with the **Administer open readspeaker** permission (or
block administration rights) can change them, so keep them pointed at the
legitimate ReadSpeaker hosts. If you run a strict Content‑Security‑Policy,
enabling the CSP module lets Open ReadSpeaker automatically add ReadSpeaker's
host to the allowed style sources (you may still need to allowlist the script
host and the `app-*.readspeaker.com` endpoint yourself).
