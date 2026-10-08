# Configuration

You configure External Script SRI on one form, where each row describes an
external script and how the browser should verify it.

## Open the settings form

1. Grant the **Administer External Script SRI** permission (it's a restricted
   permission) to a trusted administrator role at **People → Permissions**.
2. Go to **Configuration → System → External Script SRI**, or navigate directly to
   `/admin/config/system/sri-configuration`.

## Add a script

The form is a table where you add one row per external JavaScript file. For each
one you provide:

- **Module name / library name** — labels that identify the library, so you can
  keep several scripts organised on the form.
- **JavaScript file URL** — the external URL of the script. Point this at a
  **versioned URL** (one that names a specific release), not a "latest" alias —
  see the caution below.
- **SRI hash** — the integrity hash for that exact file. Generate it with a tool
  such as [srihash.org](https://www.srihash.org) (linked from the form's own help
  text) by giving it the same URL, then paste the result here.
- **Crossorigin** — the value of the `crossorigin` attribute (commonly
  `anonymous`). See the note below on why this is not optional.
- **Sensitive** *(optional)* — flag a library as sensitive to mark it for extra
  scrutiny in your own review process.

Save the form, and the module attaches the `integrity` and `crossorigin`
attributes to those scripts.

## Two things that decide whether SRI helps or breaks the page

These two operational points are the difference between SRI protecting your site
and SRI stopping a script from loading at all:

- **`crossorigin` is required for SRI to work.** The browser needs a CORS-mode
  fetch to inspect the response before it can verify the hash, and the script's
  host must send permissive CORS headers. If it doesn't, the browser refuses to
  load the script rather than merely skipping verification. So set `crossorigin`,
  and confirm the host actually serves the file with CORS headers.
- **A hash pins one exact file.** The moment the upstream file changes — even a
  legitimate update — its hash no longer matches and the browser stops running it,
  until you update the hash here. That's the feature, not a bug: it forces a
  deliberate review of third-party changes. To keep this manageable, always pin
  **versioned URLs**, and treat updating a hash as a small review step rather than
  a surprise.

## Save

Click **Save**. The specified scripts now load with SRI protection. It's worth
loading a page that uses one of them and checking the browser console: if a script
silently fails to load, the usual cause is a `crossorigin`/CORS mismatch or a hash
that doesn't match the file currently at that URL.
