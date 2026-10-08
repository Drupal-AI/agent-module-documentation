<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filename Hash Token defines file tokens for a 32-character md5 hash of the filename and for configurable substrings of that hash.

---

It registers two tokens under the `file` token type: `[file:name-hash]` (the full `md5()` of the file's
basename, 32 hex chars) and the dynamic `[file:name-hash-substring:LENGTH]` /
`[file:name-hash-substring:LENGTH,OFFSET]` (a slice of that hash). The substring token parses its arguments
into length and optional offset, defends against non-numeric offsets (falls back to 0), and only produces a
value when the length is numeric and ≤ 32. These tokens are computed from the filename's basename via
`file_system->basename()`.

The classic use is with the **File (Field) Paths** module: hashing the uploaded filename and taking a short
substring gives you a way to bucket files into subdirectories (e.g. `public://[file:name-hash-substring:4]/`)
so a single directory does not accumulate thousands of files. It needs no configuration — enabling the
module makes the tokens available anywhere Drupal tokens are; the Token module is handy for browsing them.
Note the hash is a plain **md5 of the filename**, meant for path distribution and not a security primitive
(it is not salted or content-based).

---

- Generate an md5 hash of a filename as a token.
- Take the first N characters of the filename hash.
- Take N characters at an offset from the filename hash.
- Bucket uploaded files into hashed subdirectories with File (Field) Paths.
- Avoid thousands of files piling up in one directory.
- Use [file:name-hash] to get the full 32-char hash.
- Use [file:name-hash-substring:4] for a 4-char prefix.
- Use [file:name-hash-substring:2,3] for 2 chars at offset 3.
- Build predictable, evenly-distributed file paths.
- Browse the new tokens with the Token module UI.
- Reference the tokens in a file field's directory setting.
- Keep filenames private-ish in directory structure via a hash.
- Cap substring length at 32 characters safely.
- Default a bad offset to 0 rather than erroring.
- Require no configuration after enabling.
- Work with the core File module on Drupal 8.8–11.
