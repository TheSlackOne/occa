from slither.slither import Slither

def detect_privileged_functions(contract_path):
    slither = Slither(contract_path)
    contracts = slither.contracts
    print(f"Number of contracts: {len(contracts)}")
    for contract in contracts:
        print(f"Analyzing contract: {contract.name}")
        for func in contract.functions:
            if "transfer" in func.name.lower() or "set" in func.name.lower():
                if any("onlyOwner" in modifier.name for modifier in func.modifiers) is False:
                    print(f"Suspicious Function: {func.full_name}")
                    print(f"Missing Access Control")
                    print(f"Code: {func.source_mapping}")

detect_privileged_functions("src/malicious.sol")
