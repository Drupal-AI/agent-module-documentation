Detects and merges duplicate managed files by content hash (SHA-256) and perceptual image similarity (pHash/dHash), and warns on duplicate uploads.

---

The Deduplication sub-module of Advanced Filesystem collects the project's duplicate-file tools under a "Deduplication" admin menu group. It is a routing-only module: it registers the routes, menu links and local tasks, while the controllers and forms that do the work live in the parent advanced_filesystem module. It provides exact deduplication by SHA-256 content hash (grouping identical files, previewing a group, and merging references to a canonical copy before deleting the extras), perceptual deduplication that finds visually similar images using pHash or dHash within a configurable Hamming-distance threshold, and duplicate-upload alerts that warn users when a file they are uploading already exists. Every route requires the parent module's restricted "administer advanced filesystem" permission.

---

- Identify files with byte-for-byte identical content using SHA-256 hashing.
- View groups of exact-duplicate files together.
- See where each duplicate file is referenced across content.
- Merge references to a canonical file and delete the redundant copies.
- Preview a duplicate group (size, upload date, usage count, image thumbnail) by its content hash.
- Run a cleanup pass over detected duplicates.
- Review a cleanup report of what was (or would be) removed.
- Find visually similar images even when files differ (dimensions, compression, minor edits).
- Choose the perceptual algorithm: pHash (more accurate) or dHash (faster).
- Tune the Hamming-distance threshold controlling how similar images must be to match.
- Limit perceptual scanning to specific MIME types.
- Warn users on upload when an identical file (by SHA-256) already exists.
- Configure the duplicate-alert level (warning or error) and which roles see it.
- Let users choose whether to continue an upload or reuse the existing file.
- Reclaim storage by removing redundant copies of the same asset.
- Restrict all deduplication operations to administrators via the "administer advanced filesystem" permission.
