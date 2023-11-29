from os import getenv

from transform import Transform
from common import setup_transforms, merge_transforms_1, merge_transforms_2


fn main() -> None:
    let ts: DynamicVector[Transform] = setup_transforms()
    let merge_fn_name: String = getenv("MOJO_MERGE_FN_NAME", "merge_transforms_1")
    let merge_fn: fn (DynamicVector[Transform], /) -> Transform
    if merge_fn_name == "merge_transforms_1":
        merge_fn = merge_transforms_1
    elif merge_fn_name == "merge_transforms_2":
        merge_fn = merge_transforms_2
    else:
        print("Unknown test function:", merge_fn_name)
        return
    let merged_fn: Transform = merge_fn(ts)
    let value: Float64 = merged_fn(1.0)
    print("value:", value)
