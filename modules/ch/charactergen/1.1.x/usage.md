Character Generator adds a single Token-module token, `[charactergen:random]`, that produces a 10-character alphanumeric string for use as an Automatic Entity Label.

---

Character Generator is a lightweight add-on for the Token module. Its only feature is a custom token, `[charactergen:random]`, implemented in `charactergen_tokens()`. When resolved in a context that includes a node, the token returns a 10-character string built from a Crockford-style base32 alphabet (`23456789ABCDEFGHJKLMNPQRSTUVWXYZ`, which deliberately excludes visually ambiguous characters such as `I`/`1` and `O`/`0`). The first four characters encode the current day-of-year and year; the remaining six encode the current time-of-day in milliseconds plus a small random offset. The typical deployment is to install Character Generator alongside the Token and Automatic Entity Label (auto_entitylabel) modules, then reference `[charactergen:random]` in a content type's automatic-label pattern so each node receives a compact machine-generated label. The value is intended as a human-friendly reference/registry code, not as a secret or a guaranteed-unique key — the module performs no duplicate check and offers no configuration.

---

- Enable the Token module dependency, then enable Character Generator; no configuration screen is added.
- Install the Automatic Entity Label (auto_entitylabel) module to actually apply the generated string as a node title.
- Add `[charactergen:random]` to a content type's automatic-label pattern so new nodes get a generated label.
- Generate short reference codes for content such as support tickets, requests, or submissions.
- Produce registry-number-style labels for catalog or inventory content types.
- Create tracking identifiers for form-submission or lead nodes.
- Give otherwise title-less content (e.g. anonymous feedback nodes) a readable machine label.
- Combine the token with static text in a pattern, e.g. `REF-[charactergen:random]`, for prefixed codes.
- Combine with other tokens, e.g. `[node:content-type]-[charactergen:random]`, for typed reference codes.
- Provide compact, human-typable codes that avoid ambiguous glyphs (no `0`/`O`, `1`/`I`) for print or verbal sharing.
- Preview the generated value in the Token browser UI provided by the Token module.
- Use as a drop-in label source when you do not want editors to type titles manually.
- Auto-label event, booking, or order-like content types with a short code.
- Seed short slugs or display codes for internal-facing content.
- Replace sequential/auto-increment style labels with a non-sequential-looking code.
- Use in migration or bulk-generation contexts where each node needs a label token.
- Apply to media or custom entity labels wherever the Token API and auto_entitylabel support node tokens.
- Serve as a minimal example of implementing `hook_token_info()` / `hook_tokens()` for developers.
