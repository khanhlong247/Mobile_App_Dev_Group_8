# huy_pro
![image](https://github.com/user-attachments/assets/79d3ede9-3b07-49ff-82a9-aeccede7d3c4)

#code



'''
// Class User
class User {
  String username;
  String password;
  String role;

  User({required this.username, required this.password, required this.role});
}

// Màn hình nhập thông tin và hiển thị danh sách người dùng
class UserInputScreen extends StatefulWidget {
  final List<User> userList;

  const UserInputScreen({
    super.key,
    required this.userList,
  });

  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.userList.add(User(
          username: _usernameController.text,
          password: _passwordController.text,
          role: _roleController.text,
        ));
      });
      _usernameController.clear();
      _passwordController.clear();
      _roleController.clear();
    }
  }

  void _deleteUser(int index) {
    setState(() {
      widget.userList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Form nhập thông tin
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _roleController,
                    decoration: const InputDecoration(labelText: 'Role'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập role';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addUser,
                    child: const Text('Thêm người dùng'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          // Hiển thị danh sách người dùng
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2.5, // Tăng chiều cao để tránh overflow
              ),
              itemCount: widget.userList.length,
              itemBuilder: (context, index) {
                final user = widget.userList[index];
                return Card(
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Username: ${user.username}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Role: ${user.role}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            _deleteUser(index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(50, 30), // Giảm kích thước nút
                          ),
                          child: const Text(
                            'Xóa',
                            style: TextStyle(fontSize: 12), // Giảm kích thước chữ
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
'''
