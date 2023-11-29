# Rule to format the code
format:
	@echo "make: Formatting code..."
	@mojo format --line-length 120 .
	@echo "make: Done."

main1:
	@echo "make: Running main1..."
	@mojo run main1.mojo
	@echo "make: Done."

main2:
	@echo "make: Running main2..."
	@mojo run main2.mojo
	@echo "make: Done."

main3_merge_transforms_1: MOJO_MERGE_FN_NAME = merge_transforms_1
main3_merge_transforms_1:
	@echo "make: Running main3 with MOJO_MERGE_FN_NAME=merge_transforms_1..."
	@mojo run main3.mojo
	@echo "make: Done."

main3_merge_transforms_2: MOJO_MERGE_FN_NAME = merge_transforms_2
main3_merge_transforms_2:
	@echo "make: Running main3 with MOJO_MERGE_FN_NAME=merge_transforms_2..."
	@mojo run main3.mojo
	@echo "make: Done."