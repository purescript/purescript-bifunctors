## Module Control.Biapply

#### `(<<$>>)`

``` purescript
(<<$>>) :: forall a b. (a -> b) -> a -> b
```

A convenience function which can be used to apply the result of `bipure` in
the style of `Applicative`:

```purescript
bipure f g <<$>> x <<*>> y
```

#### `Biapply`

``` purescript
class (Bifunctor w) <= Biapply w where
  biapply :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d
```

`Biapply` captures type constructors of two arguments which support lifting of
functions of one or more arguments, in the sense of `Apply`.

#### `(<<*>>)`

``` purescript
(<<*>>) :: forall w a b c d. (Biapply w) => w (a -> b) (c -> d) -> w a c -> w b d
```

An infix version of `biapply`.

#### `(*>>)`

``` purescript
(*>>) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w c d
```

Keep the results of the second computation

#### `(<<*)`

``` purescript
(<<*) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w a b
```

Keep the results of the first computation

#### `bilift2`

``` purescript
bilift2 :: forall w a b c d e f. (Biapply w) => (a -> b -> c) -> (d -> e -> f) -> w a d -> w b e -> w c f
```

Lift a function of two arguments.

#### `bilift3`

``` purescript
bilift3 :: forall w a b c d e f g h. (Biapply w) => (a -> b -> c -> d) -> (e -> f -> g -> h) -> w a e -> w b f -> w c g -> w d h
```

Lift a function of three arguments.


