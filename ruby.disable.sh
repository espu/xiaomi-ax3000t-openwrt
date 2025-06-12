#!/bin/bash

# CONFIG_PACKAGE_ruby-bigdecimal is not set
# CONFIG_PACKAGE_ruby-date is not set
# CONFIG_PACKAGE_ruby-digest is not set
# CONFIG_PACKAGE_ruby-enc is not set
# CONFIG_PACKAGE_ruby-pstore is not set
# CONFIG_PACKAGE_ruby-psych is not set
# CONFIG_PACKAGE_ruby-stringio is not set
# CONFIG_PACKAGE_ruby-yaml is not set

# 彻底禁用 Ruby 及其所有相关组件

echo "开始彻底禁用 Ruby 环境..."

# 1. 禁用所有 Ruby 相关包（从您的 .config 文件中找到的）
echo "禁用 Ruby 核心包..."
sed -i 's/CONFIG_PACKAGE_ruby=y/# CONFIG_PACKAGE_ruby is not set/g' .config
sed -i 's/CONFIG_PACKAGE_libruby=y/# CONFIG_PACKAGE_libruby is not set/g' .config

# 2. 禁用所有 Ruby 子模块
echo "禁用 Ruby 子模块..."
sed -i 's/CONFIG_PACKAGE_ruby-bigdecimal=y/# CONFIG_PACKAGE_ruby-bigdecimal is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-date=y/# CONFIG_PACKAGE_ruby-date is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-digest=y/# CONFIG_PACKAGE_ruby-digest is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-enc=y/# CONFIG_PACKAGE_ruby-enc is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-pstore=y/# CONFIG_PACKAGE_ruby-pstore is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-psych=y/# CONFIG_PACKAGE_ruby-psych is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-stringio=y/# CONFIG_PACKAGE_ruby-stringio is not set/g' .config
sed -i 's/CONFIG_PACKAGE_ruby-yaml=y/# CONFIG_PACKAGE_ruby-yaml is not set/g' .config

# 3. 禁用 Ruby 构建选项
echo "禁用 Ruby 构建选项..."
sed -i 's/CONFIG_RUBY_ENABLE_YJIT=y/# CONFIG_RUBY_ENABLE_YJIT is not set/g' .config

# 4. 检查并禁用可能依赖 Ruby 的其他包
echo "检查依赖 Ruby 的包..."

# 检查是否有其他包依赖 Ruby（常见的包）
if grep -q "CONFIG_PACKAGE_.*=y" .config; then
    echo "检查可能依赖 Ruby 的包："
    
    # 一些常见的可能依赖 Ruby 的包
    RUBY_DEPENDENT_PACKAGES=(
        "fluentd"
        "logstash"
        "puppet"
        "chef"
        "vagrant"
        "jekyll"
        "rails"
        "gem"
    )
    
    for package in "${RUBY_DEPENDENT_PACKAGES[@]}"; do
        if grep -q "CONFIG_PACKAGE_.*${package}.*=y" .config; then
            echo "⚠️  发现可能依赖 Ruby 的包: $package"
            echo "建议手动检查是否需要禁用此包"
        fi
    done
fi

# 5. 验证禁用结果
echo ""
echo "=== 验证 Ruby 禁用结果 ==="
ruby_enabled=$(grep -c "CONFIG_PACKAGE_ruby.*=y" .config || echo "0")
ruby_disabled=$(grep -c "CONFIG_PACKAGE_ruby.*is not set" .config || echo "0")

echo "启用的 Ruby 包数量: $ruby_enabled"
echo "禁用的 Ruby 包数量: $ruby_disabled"

if [ "$ruby_enabled" -eq 0 ]; then
    echo "✅ Ruby 环境已完全禁用"
else
    echo "❌ 仍有 Ruby 包未禁用，请检查以下包："
    grep "CONFIG_PACKAGE_ruby.*=y" .config
fi

echo ""
echo "=== 完整的 Ruby 相关配置状态 ==="
grep "CONFIG_PACKAGE_ruby" .config | sort

# 6. 高级检查：查找所有可能的 Ruby 相关配置
echo ""
echo "=== 查找所有可能的 Ruby 相关配置 ==="
grep -i "ruby\|gem" .config | grep -v "^#" || echo "未找到其他 Ruby 相关配置"

echo ""
echo "Ruby 禁用脚本执行完成！"