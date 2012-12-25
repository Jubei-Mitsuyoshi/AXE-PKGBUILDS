.PHONY: clean print_clean
clean:
	rm -rf $(CLEAN)
print_clean:
	@echo "File to remove at clean: $(CLEAN)"
