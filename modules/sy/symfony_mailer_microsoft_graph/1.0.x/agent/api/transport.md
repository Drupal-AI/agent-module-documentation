# Transport factory, DSN, and the send path (API)

## Transport factory service — `mailer.transport_factory.microsoft_graph`

`Transport/MicrosoftGraphTransportFactory` (final, extends Symfony `AbstractTransportFactory`),
registered in `symfony_mailer_microsoft_graph.services.yml` with tag
`mailer.transport_factory` (priority `-100`). It supports one scheme, `msgraph`
(`MicrosoftGraphTransport::LABEL`), and `create(Dsn $dsn)` returns a `MicrosoftGraphApiTransport`
built from:

```php
new MicrosoftGraphApiTransport(
  tenantId:     $dsn->getOption('tenant') ?? '',
  clientId:     $dsn->getOption('client_id') ?? '',
  clientSecret: $dsn->getOption('client_secret') ?? '',
  user:         $dsn->getUser(),              // mailbox to send as
  client:       $this->client,                // injected Symfony HttpClient (see note)
  dispatcher:   $this->dispatcher,
  logger:       $this->logger,
);
```

A non-`msgraph` scheme throws `Symfony\Component\Mailer\Exception\UnsupportedSchemeException`.

## API transport — `Transport/Api/MicrosoftGraphApiTransport`

Extends Symfony `AbstractApiTransport`. Constructor takes `(string $tenantId, string $clientId,
string $clientSecret, string $user, ?HttpClientInterface $client, ?EventDispatcherInterface
$dispatcher, ?LoggerInterface $logger)`.

Auth uses OAuth2 **client credentials**:

```php
private function getCredentialContext(): ClientCredentialContext {
  return new ClientCredentialContext($this->tenantId, $this->clientId, $this->clientSecret);
}
```

- `testAuthToken(): ?string` — builds a `GraphPhpLeagueAccessTokenProvider` and fetches a token for
  `https://graph.microsoft.com` (synchronously via `->wait()`). Public; not called elsewhere in the
  module (useful as a credentials smoke-test).
- `getSendMailRequestBuilder()` — **constructs a fresh `GraphServiceClient($this->getCredentialContext())`**
  and returns `->users()->byUserId($this->user)->sendMail()`. Note: it does **not** reuse the
  injected Symfony `$client`; the Graph SDK builds its own Guzzle-based HTTP client (TLS verification
  is the SDK/Guzzle default — the module never disables it).

### `doSendApi(SentMessage, Email, Envelope): ResponseInterface`

1. Convert the Symfony `Email` to a Graph `Message` (`convertToMicrosoftGraphEmailMessage()`); a
   conversion `TransportException` is caught and returned as a synthetic 500 `MicrosoftGraphResponse`.
2. Wrap it in `SendMailPostRequestBody`, attach a `NativeResponseHandler`, and
   `->post($requestBody, $config)->wait()`.
3. If the Graph PSR-7 response is **HTTP 202**, return a synthetic **200** `MicrosoftGraphResponse`
   (`content: "The sendMail graph call was successful."`).
4. If there is no response, throw `TransportException('MS Graph API error: no response.')`.
5. Otherwise throw `TransportException('MS Graph API error %d with: %s', status, body)` — the message
   includes the **Graph error response body** (not the credentials).

### Email → Graph `Message` mapping (`convertToMicrosoftGraphEmailMessage`)

- Sender, To, Cc, Bcc, Reply-To, From — each Symfony `Address` becomes a Graph `Recipient`
  (`convertToEmailAddress()`: `EmailAddress` with address + display name).
- **From:** more than one `From` address throws
  `TransportException('Cannot send a mail from multiple "From" recipients ...')`.
- **Body:** if the email has a non-empty HTML body it is sent as `BodyType::HTML`, otherwise the text
  body as `BodyType::TEXT`.
- **Subject:** copied verbatim.
- **Attachments:** each Symfony `DataPart` → a Graph `FileAttachment` (`setName($filename)`,
  `setContentBytes(Utils::streamFor($part->bodyToString()))`).

## Response wrapper — `Response/MicrosoftGraphResponse`

Implements Symfony HttpClient `ResponseInterface` as a minimal value object: `getStatusCode()`,
`getHeaders()`, `getContent()` return the injected values; `toArray()` returns `[]`; `getInfo()`
returns the `responseInfo` array (or a single key). It only carries the synthetic status/message the
transport produced above; it does not expose the real Graph HTTP response.

## Scheme / string identity

`MicrosoftGraphApiTransport::__toString()` returns `"msgraph://"` (no credentials), and
`supports(Dsn $dsn)` is true only when `$dsn->getScheme() === 'msgraph'`.
