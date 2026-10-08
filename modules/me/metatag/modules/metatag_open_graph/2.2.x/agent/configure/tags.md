# Open Graph tags

Adds an "Open Graph" MetatagTag group (~59 tags), emitted as `<meta property="…">`.

- **Core** — `og:title`, `og:description`, `og:url`, `og:type`, `og:site_name`,
  `og:determiner`, `og:locale`, `og:locale:alternate`, `og:see_also`, `fediverse:creator`.
- **Image** — `og:image`, `og:image:url`, `og:image:secure_url`, `og:image:type`,
  `og:image:width`, `og:image:height`, `og:image:alt`.
- **Video / audio** — `og:video`(+`:secure_url`,`:type`,`:width`,`:height`,`:duration`),
  `og:audio`(+`:secure_url`,`:type`).
- **article:** — `published_time`, `modified_time`, `expiration_time`, `author`,
  `section`, `tag`, `publisher`.
- **book:** — `author`, `isbn`, `release_date`, `tag`.
- **profile:** — `first_name`, `last_name`, `username`, `gender`.
- **video:** (object) — `actor`, `actor:role`, `director`, `writer`, `series`,
  `release_date`, `tag`.
- **Contact/place** — `og:email`, `og:phone_number`, `og:fax_number`,
  `og:street_address`, `og:locality`, `og:region`, `og:postal_code`, `og:country_name`,
  `place:location:latitude`, `place:location:longitude`.

Set as Metatag defaults or per entity; token-enabled (map `og:image` to an image field).
Schema: `config/schema/metatag_open_graph.metatag_tag.schema.yml`.
