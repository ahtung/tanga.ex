# Tanga

[![Build Status](https://travis-ci.org/ahtung/tanga.ex.svg?branch=master)](https://travis-ci.org/ahtung/tanga.ex)
[![Coverage Status](https://coveralls.io/repos/ahtung/tanga.ex/badge.svg?branch=master)](https://coveralls.io/r/ahtung/tanga.ex?branch=master)
[![Hex.pm version](https://img.shields.io/hexpm/v/tanga.svg?style=flat-square)](https://hex.pm/packages/tanga)
[![Hex.pm downloads](https://img.shields.io/hexpm/dt/tanga.svg)](https://hex.pm/packages/tanga)

Sexier strings for Elixir

## Usage

```elixir
# next
"aab" = Tanga.next("aaa")

# squeeze
"yelow mon" = Tanga.squeeze("yellow moon")

# center
"       hello        " = Tanga.center("hello", 20)

# swapcase
"hELLO" = Tanga.swapcase("Hello")
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tanga` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tanga, "~> 0.7.0"}
  ]
end
```

## Roadmap

- [x] Swapcase
- [x] Center
- [ ] Next
- [ ] Squeeze

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tanga](https://hexdocs.pm/tanga).
