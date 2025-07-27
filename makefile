ios_clean:
	pushd ios && rm -rf Pods .symlinks Podfile.lock && pod deintegrate && pod install --repo-update && popd