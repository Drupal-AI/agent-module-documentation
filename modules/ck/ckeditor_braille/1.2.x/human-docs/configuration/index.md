# Configuration

CKEditor Braille is configured **per text format**, not on a central admin page.
The settings only appear once you have added the Braille toolbar item to a
CKEditor 5 format, so start there.

## 1. Add the Braille toolbar item

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. **Configure** (or create) a format that uses CKEditor 5.
4. In the CKEditor 5 toolbar configuration, drag the **Braille** item into the
   *Active toolbar*.

Once the Braille item is in the toolbar, a settings section appears on the same
text-format configuration page.

## 2. Set the letter-to-Braille mappings

The core of the configuration is mapping letter combinations to Braille Unicode
values. Because this is done per format, different text formats can use different
mappings. Set the values you want each key combination (for example the `f d s j
k l` Braille keys) to produce.

## 3. The API, UI, and Speech sections

The settings form is organised into three sections:

- **API** — options for the practice/challenge feature, which can fetch challenge
  data from an external endpoint. On locked-down sites, be aware this is an
  outbound network request.
- **UI** — options controlling the Braille input interface in the editor
  (for example how input and transliteration behave).
- **Speech** — options for the speech-synthesis integration, which can read
  content back to the user.

For the full details of each option, see the module's `README.md`.

## Save

Save the plugin settings and then **Save configuration** on the text format.
Editors using that format can then toggle Braille input from the toolbar, type
Braille with the mapped key combinations, and transliterate between text and
Braille. The text-format filter renders Braille in the output, and learners can
practise at `/ckeditor-braille/exercise`.
