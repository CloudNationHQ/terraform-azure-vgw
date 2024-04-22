.PHONY: test

export TF_PATH

test:
	cd tests && go test -v -timeout 60m -run TestApplyNoError/$(TF_PATH) ./vgw_test.go

#test_extended:
	#cd tests && env go test -v -timeout 60m -run TestVm ./vgw_extended_test.go
