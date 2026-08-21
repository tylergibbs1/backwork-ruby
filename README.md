# Backwork Ruby SDK

Official Ruby client for the [Backwork API](https://backworkhealth.com): Medicare coverage policies, medical code intelligence, prior authorization checks, claim validation, compliance review, and drug formulary evidence.

## Installation

```bash
gem install backwork-sdk
```

Or build this repository from source:

```bash
git clone https://github.com/tylergibbs1/backwork-ruby.git
cd backwork-ruby
gem build backwork-sdk.gemspec
gem install ./backwork-sdk-*.gem
```

Requires Ruby 2.7 or newer.

## Quick Start

```ruby
require 'backwork'

client = Backwork::Client.new(api_key: 'bwk_live_YOUR_API_KEY')

code = client.codes.lookup('76942', include: ['rvu', 'policies'])
puts code['data']['description']

prior_auth = client.prior_auth.check(
  procedure_codes: ['76942'],
  diagnosis_codes: ['M54.5'],
  state: 'TX',
  payer: 'medicare'
)

puts prior_auth['data']['pa_required']
```

Get an API key from the [Backwork dashboard](https://backworkhealth.com/dashboard).

## Core Workflows

### Code Lookup

```ruby
result = client.codes.lookup(
  '76942',
  include: ['rvu', 'policies'],
  jurisdiction: 'JM',
  fuzzy: true
)
```

### Policy Search and Retrieval

```ruby
policies = client.policies.list(
  q: 'ultrasound guidance',
  mode: 'keyword',
  policy_type: 'LCD',
  jurisdiction: 'JM',
  status: 'active',
  limit: 25
)

policy = client.policies.get('L33831', include: ['criteria', 'codes'])
```

### Prior Authorization and Claim Validation

```ruby
prior_auth = client.prior_auth.check(
  procedure_codes: ['76942'],
  diagnosis_codes: ['M54.5'],
  state: 'TX',
  payer: 'medicare'
)

claim = client.claims.validate(
  procedure_codes: ['99213'],
  diagnosis_codes: ['E11.9'],
  payer: 'Medicare',
  state: 'TX',
  date_of_service: '2026-05-23'
)

puts "#{claim['data']['coverage_status']} #{claim['data']['denial_risk']}"
puts claim['data']['issues']
```

### Coverage, Spending, and Compliance

```ruby
criteria = client.coverage.search_criteria(
  'diabetes',
  section: 'indications',
  limit: 10
)
puts "#{criteria['data'][0]['policy_id']}: #{criteria['data'][0]['policy_title']}"

spending = client.spending.by_code(codes: ['T1019', 'T1020'], year: 2023)
changes = client.compliance.unreviewed(limit: 10)
stats = client.compliance.stats
```

### Drug Formulary Evidence

```ruby
formulary = client.drugs.formulary('ozempic', payer: 'all', limit: 5)
```

## Error Handling

```ruby
begin
  result = client.codes.lookup('76942')
rescue Backwork::AuthError => e
  puts "Invalid API key: #{e.message}"
rescue Backwork::ValidationError => e
  puts "Invalid request: #{e.message}"
rescue Backwork::NotFoundError => e
  puts "Resource not found: #{e.message}"
rescue Backwork::RateLimitError => e
  puts "Rate limit exceeded: #{e.message}"
rescue Backwork::APIError => e
  puts "Backwork API error: #{e.message}"
end
```

## Configuration

```ruby
client = Backwork::Client.new(
  api_key: ENV.fetch('BACKWORK_API_KEY'),
  base_url: 'https://backworkhealth.com/api/v1',
  timeout: 30
)
```

## Development

```bash
bundle install
ruby -c lib/backwork.rb
gem build backwork-sdk.gemspec
bundle exec rake build
```

## Release

1. Configure a RubyGems Trusted Publisher for `tylergibbs1/backwork-ruby`, workflow `release.yml`, environment `release`, gem name `backwork-sdk`.
2. Update `lib/backwork/version.rb`.
3. Push a matching tag, for example `v2.0.0`.
4. The release workflow builds and pushes the gem through RubyGems OIDC trusted publishing.

## Support

- Documentation: https://backworkhealth.com/docs
- Issues: https://github.com/tylergibbs1/backwork-ruby/issues
- Email: support@backworkhealth.com

## License

MIT
