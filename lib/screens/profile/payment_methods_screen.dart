import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': '1',
      'type': 'Credit Card',
      'name': 'Visa ****1234',
      'icon': Icons.credit_card,
      'isDefault': true,
      'expiryDate': '12/25',
      'cardType': 'Visa',
    },
    {
      'id': '2',
      'type': 'Bank Account',
      'name': 'Chase Bank ****5678',
      'icon': Icons.account_balance,
      'isDefault': false,
      'accountType': 'Checking',
      'bankName': 'Chase Bank',
    },
    {
      'id': '3',
      'type': 'Digital Wallet',
      'name': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'isDefault': false,
      'email': 'user@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAddPaymentMethodCard(),
                const SizedBox(height: 20),
                _buildPaymentMethodsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPaymentMethodCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 48,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 12),
          const Text(
            'Add New Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a credit card, bank account, or digital wallet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddPaymentMethodDialog('Credit Card'),
                  icon: const Icon(Icons.credit_card),
                  label: const Text('Card'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddPaymentMethodDialog('Bank Account'),
                  icon: const Icon(Icons.account_balance),
                  label: const Text('Bank'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Payment Methods',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ..._paymentMethods.map((method) => _buildPaymentMethodCard(method)),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: method['isDefault'] 
            ? Border.all(color: AppTheme.primaryColor, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              method['icon'],
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    if (method['isDefault']) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _getPaymentMethodSubtitle(method),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handlePaymentMethodAction(value, method),
            itemBuilder: (context) => [
              if (!method['isDefault'])
                const PopupMenuItem(
                  value: 'set_default',
                  child: Text('Set as Default'),
                ),
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            child: const Icon(
              Icons.more_vert,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodSubtitle(Map<String, dynamic> method) {
    switch (method['type']) {
      case 'Credit Card':
        return '${method['cardType']} • Expires ${method['expiryDate']}';
      case 'Bank Account':
        return '${method['bankName']} • ${method['accountType']}';
      case 'Digital Wallet':
        return method['email'];
      default:
        return method['type'];
    }
  }

  void _handlePaymentMethodAction(String action, Map<String, dynamic> method) {
    switch (action) {
      case 'set_default':
        setState(() {
          for (var m in _paymentMethods) {
            m['isDefault'] = false;
          }
          method['isDefault'] = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${method['name']} set as default'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        break;
      case 'edit':
        _showEditPaymentMethodDialog(method);
        break;
      case 'delete':
        _showDeleteConfirmationDialog(method);
        break;
    }
  }

  void _showAddPaymentMethodDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type == 'Credit Card' ? Icons.credit_card : Icons.account_balance,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'This is a demo. In a real app, you would enter your $type details here.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addDemoPaymentMethod(type);
            },
            child: const Text('Add Demo Method'),
          ),
        ],
      ),
    );
  }

  void _showEditPaymentMethodDialog(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Payment Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              method['icon'],
              size: 48,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'This is a demo. In a real app, you would edit the payment method details here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment method updated (demo)'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Method'),
        content: Text(
          'Are you sure you want to delete ${method['name']}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _paymentMethods.removeWhere((m) => m['id'] == method['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${method['name']} deleted'),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _addDemoPaymentMethod(String type) {
    final newMethod = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'type': type,
      'name': type == 'Credit Card' ? 'Demo Card ****9999' : 'Demo Bank ****0000',
      'icon': type == 'Credit Card' ? Icons.credit_card : Icons.account_balance,
      'isDefault': false,
    };

    if (type == 'Credit Card') {
      newMethod['expiryDate'] = '12/28';
      newMethod['cardType'] = 'Demo';
    } else {
      newMethod['accountType'] = 'Checking';
      newMethod['bankName'] = 'Demo Bank';
    }

    setState(() {
      _paymentMethods.add(newMethod);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Demo $type added successfully'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }
}