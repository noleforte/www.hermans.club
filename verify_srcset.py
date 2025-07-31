# Verification script to check for remaining srcset issues
import re

def check_srcset_issues(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Check for problematic patterns
    patterns = [
        r'srcset="[^"]*?384w\?url=',
        r'srcset="[^"]*?384w[^"]*?[^w][^"]*?"',
        r'srcset="[^"]*?\?[^"]*?"'
    ]
    
    issues_found = 0
    for pattern in patterns:
        matches = re.findall(pattern, content)
        if matches:
            print(f"Found {len(matches)} issues with pattern: {pattern}")
            issues_found += len(matches)
    
    if issues_found == 0:
        print("âœ… No srcset parsing issues found!")
    else:
        print(f"âš ï¸  Found {issues_found} remaining issues")
    
    return issues_found == 0

if __name__ == "__main__":
    check_srcset_issues("collection_fixed_comprehensive.html")
