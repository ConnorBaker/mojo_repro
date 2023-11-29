@value
@register_passable("trivial")
struct ComposeTransform:
    """
    Sequentially compose two transforms.

    Equivalent to `g(f(x))`. Note that the order of composition is reversed
    compared to the order the arguments -- this is not the equivalent of
    Haskell's `.` operator.
    """

    var f: Transform
    var g: Transform

    fn get_transform(self) -> Transform:
        fn transform(x: Float64, /) -> Float64:
            return self.g(self.f(x))

        return transform
